module AdminHelper
    def my_will_paginate object
        "<div class='apple_pagination'>" + 
            "<div class='page_info'>" +
            "#{page_entries_info(object)}" +
            "</div>" +
            "#{will_paginate(object, :container => false)}" +
        "</div>"
    end
end
