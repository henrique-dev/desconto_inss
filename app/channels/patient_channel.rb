class PatientChannel < ApplicationCable::Channel
    def subscribed
        stream_from "patient_#{current_patient.id}"
    end

    def check_new_messages(data)
        message_manager = current_patient.patient_profile.message_manager
        messages = message_manager.messages.where(active: true)
        if (messages.count == 0)
            messages = []
            messages << Message.new({
                message: "Em que posso ajudar?",
                from: "sistema",
                from_client: false
            })
        end
        ActionCable.server.broadcast "patient_#{current_patient.id}",
        { 
            action: data["action"],
            messages: messages
        }
    end

    def new_message(data)
        patient_profile = current_patient.patient_profile
        message_manager = MessageManager.find(patient_profile.message_manager.id)
        message_manager.active = true
        message_manager.save
        message = Message.create!({
            message: "#{data["body"]}",
            from: patient_profile.name,
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