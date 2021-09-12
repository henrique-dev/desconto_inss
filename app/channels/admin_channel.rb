class AdminChannel < ApplicationCable::Channel

    def subscribed
        stream_from "admin_#{current_admin.id}"
    end

    def check_new_managers
        message_managers = MessageManager.where(active: true)
        message_managers.each do |message_manager|
            message_manager.last_active_message = message_manager.last_message
        end
        ActionCable.server.broadcast "admin_#{current_admin.id}",
        { 
            action: "check_new_managers",
            message_managers: message_managers.to_json(methods: [:last_active_message])
        }
    end

    def check_new_messages data
        message_manager = MessageManager.find(data["body"])
        ActionCable.server.broadcast "admin_#{current_admin.id}",
        { 
            action: "check_new_messages",
            message_manager: message_manager,
            messages: message_manager.messages.where(active: true)
        }
    end

    def new_message data
        message_manager = MessageManager.find(data["body"]["message_manager"]["id"])
        message = Message.create!({
            message: "#{data["body"]["message"]}",
            from: current_admin.email,
            from_client: false,
            active: true,
            message_manager: message_manager
        })
        if (patient_profile = message_manager.patient_profile)
            Admin.all.each do |admin|
                ActionCable.server.broadcast "admin_#{admin.id}",
                { 
                    action: "new_message",
                    message_manager: message_manager,
                    message: message
                }
            end
            ActionCable.server.broadcast "patient_#{patient_profile.patient.id}",
            { 
                action: "new_message",
                message_manager: message_manager,
                message: message
            }
        elsif (medic_profile = message_manager.medic_profile)
            Admin.all.each do |admin|
                ActionCable.server.broadcast "admin_#{admin.id}",
                { 
                    action: "new_message",
                    message_manager: message_manager,
                    message: message
                }
            end
            ActionCable.server.broadcast "medic_#{medic_profile.medic.id}",
            { 
                action: "new_message",
                message_manager: message_manager,
                message: message
            }
        end
    end

    def finalize data
        message_manager = MessageManager.find(data["body"]["message_manager"]["id"])
        message_manager.messages.where(active: true).each do |message|
            message.active = false
            message.save
        end
        message_manager.active = false
        message_manager.save
        Admin.all.each do |admin|
            ActionCable.server.broadcast "admin_#{admin.id}",
            { 
                action: "finalize",
                message_manager: message_manager
            }
        end
    end
end