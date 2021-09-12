class MedicChannel < ApplicationCable::Channel
    def subscribed
        stream_from "medic_#{current_medic.id}"
    end

    def check_new_messages(data)
        message_manager = current_medic.medic_profile.message_manager
        messages = message_manager.messages.where(active: true)
        if (messages.count == 0)
            messages = []
            messages << Message.new({
                message: "Em que posso ajudar?",
                from: "sistema",
                from_client: false
            })
        end
        ActionCable.server.broadcast "medic_#{current_medic.id}",
        { 
            action: data["action"],
            messages: messages
        }
    end

    def new_message(data)
        medic_profile = current_medic.medic_profile
        message_manager = MessageManager.find(medic_profile.message_manager.id)
        message_manager.active = true
        message_manager.save
        message = Message.create!({
            message: "#{data["body"]}",
            from: medic_profile.name,
            from_client: true,
            active: true,
            message_manager: message_manager
        })
        Admin.all.each do |admin|
            ActionCable.server.broadcast "admin_#{admin.id}",
            { 
                action: "new_message",
                message_manager: message_manager,
                message: message
            }
        end
    end
end