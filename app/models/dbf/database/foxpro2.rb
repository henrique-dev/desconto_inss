module DBF
    module Database
        class Foxpro2
            def initialize(path)
                @path = path
                @dirname = File.dirname(@path)
                @db = DBF::Table.new(@path)
                @tables = extract_dbc_data
            rescue Errno::ENOENT
                raise DBF::FileNotFoundError, "file not found: #{data}"
            end

            def table_names
                @tables.keys
            end
        
            # Returns table with given name
            # @return Table
            def table(name)
                Table.new table_path(name) do |table|
                table.long_names = @tables[name]
                end
            end

            def table_path(name)
                glob = File.join(@dirname, "#{name}.dbf")
                path = Dir.glob(glob, File::FNM_CASEFOLD).first
        
                raise DBF::FileNotFoundError, "related table not found: #{name}" unless path && File.exist?(path)
        
                path
            end
        
            def method_missing(method, *args) # :nodoc:
                table_names.index(method.to_s) ? table(method.to_s) : super
            end
        
            def respond_to_missing?(method, *)
                table_names.index(method.to_s) || super
            end

            private

            def extract_dbc_data # :nodoc:
                data = {}
                @db.each do |record|
                    next unless record

                    puts "heeeeeeeeeeeeeeeeeeeeere".red
                    #p record.column_names
                    ap record.to_a
                    puts "heeeeeeeeeeeeeeeeeeeeere".red
            
                    process_field record, data
                    #case record.objecttype
                    #    when 'Table'
                    #        # This is a related table
                    #        process_table record, data
                    #    when 'Field'
                    #        # This is a related field. The parentid points to the table object.
                    #        # Create using the parentid if the parentid is still unknown.
                    #        process_field record, data
                    #end
                end
                Hash[
                    data.values.map { |v| [v[:name], v[:fields]] }
                ]
            end

            def process_table(record, data)
                id = record.objectid
                name = record.objectname
                data[id] = table_field_hash(name)
            end
        
            def process_field(record, data)
                id = record.parentid
                name = 'UNKNOWN'
                field = record.objectname
                data[id] ||= table_field_hash(name)
                data[id][:fields] << field
            end

            def table_field_hash(name)
                {name: name, fields: []}
            end
        end

        class Table < DBF::Table
            attr_accessor :long_names
    
            def build_columns # :nodoc:
                columns = super
        
                # modify the column definitions to use the long names as the
                # columnname property is readonly, recreate the column definitions
                columns.map do |column|
                    long_name = long_names[columns.index(column)]
                    Column.new(self, long_name, column.type, column.length, column.decimal)
                end
            end
        end
    end
end