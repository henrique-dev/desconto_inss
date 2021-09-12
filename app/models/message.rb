class Message < ApplicationRecord
  belongs_to :message_manager, optional: true
end
