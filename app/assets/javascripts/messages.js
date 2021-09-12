//= require cable
//= require jquery
//= require jquery.inputmask/dist/jquery.inputmask.bundle

let managersIds = [];

function dataReceived(data) {
    switch(data.action) {
        case "check_new_managers" : {
            managersIds = [];
            let container = jQuery("#message_managers_container");
            container.empty();
            let messageManagers = JSON.parse(data.message_managers);
            messageManagers.forEach(function(messageManager) {
                managersIds.push(messageManager.id);
                container.append(
                    "<div id='message_manager_"+messageManager.id+"' class='mail_list message-manager' style='cursor: pointer' data-id='"+messageManager.id+"'>"
                        +"<div class='left'>"
                            +"<i class='fa fa-circle'></i>"
                        +"</div>"
                        +"<div class='right'>"
                            +"<h3>" + messageManager.last_active_message.from + "</h3>"
                            +"<p>" + messageManager.last_active_message.message + "</p>"
                        +"</div>"
                    +"</div>"
                )
            });

            jQuery(".mail_list").off().click(function() {
                let messageManagaerId = jQuery(this).data("id");
                App.room.send({ action: "check_new_messages", body: messageManagaerId});
            });

            if (managersIds.length == 0) {
                container.empty().append("<h3>Sem threads</h3>")
            }
            jQuery("#messages_container").empty().append("<h3>Nenhuma conversa para mostrar</h3>");
            break;
        }
        case "check_new_messages" : {            
            let container = jQuery("#messages_container");
            let messageManager = data.message_manager;
            container.data("id", messageManager.id);
            let messages = data.messages;
            let htmlMessages = [];
            messages.forEach(function(message) {
                htmlMessages.push(
                    "<div class='row'>"
                        +"<div class='col-12' style='margin: 15px; text-align: " + (message.from_client ? "left" : "right") + "'>"
                            +"<span style='padding: 15px; background: "+ (message.from_client ? "#D4EFDF" : "#F2F3F4") +";'>"
                                +message.message
                            +"<span>"
                        +"</div>"
                    +"</div>"
                )
            });
            container.empty();
            container.append(
                "<div class='row' style='height: 80%; width: 100%; margin-right: 0'>"
                    +"<div id='container_talk' class='col-12' style='overflow-y: auto; overflow-x: hidden; max-height: 100%'>"
                        + htmlMessages.join("")
                    +"</div>"
                +"</div>"
                + "<hr>"
                +"<div class='row' style='height: 20%; width: 100%; '>"
                    +"<div class='col-12'>"
                        +"<div class='row'>"
                            +"<div class='col-12'>"
                                +"<div style='width:100%; height:100%; padding: 15px 0 5px 0'>"
                                    +"<textarea id='textarea_message' style='width: 100%; height: 100%; resize: none;'>"
                                    +"</textarea>"
                                +"</div>"
                            +"</div>"
                        +"</div>"
                        +"<div class='row' style='text-align: right'>"
                            +"<div class='col-12'>"
                                +"<div style='width:100%; height:100%;'>"
                                    +"<button id='btn_finalize' class='btn btn-success' data-id='"+messageManager.id+"'>Finalizar atendimento</button>"
                                    +"<button id='btn_send_message' class='btn btn-primary' data-id='"+messageManager.id+"'>Enviar</button>"
                                +"</div>"
                            +"</div>"
                        +"</div>"                    
                    +"</div>"                    
                +"</div>"
            );
            let containerTalk = jQuery("#container_talk");
            containerTalk[0].scrollTo(0, containerTalk[0].scrollHeight);
            jQuery("#btn_send_message").off().click(function() {
                let messageManagerId = jQuery(this).data("id");
                let message = jQuery("#textarea_message").val();
                if (message.length > 0) {                    
                    App.room.send({ action: "new_message", body: {
                        message_manager: {
                            id: messageManagerId
                        },
                        message: message
                    }});
                }
            });
            jQuery("#btn_finalize").off().click(function() {
                let messageManagerId = jQuery(this).data("id");
                App.room.send({ action: "finalize", body: {
                    message_manager: {
                        id: messageManagerId
                    }
                }});
            });
            break;
        }
        case "new_message" : {
            let messageManagerContainer = jQuery("#message_managers_container");
            let container = jQuery("#messages_container");
            let messageManager = data.message_manager;
            if (container.length > 0 && messageManager.id == container.data("id")) {
                let containerTalk = jQuery("#container_talk");
                let message = data.message;
                jQuery("#textarea_message").val("");                
                containerTalk.append(
                    "<div class='row'>"
                        +"<div class='col-12' style='margin: 15px; text-align: " + (message.from_client ? "left" : "right") + "'>"
                            +"<span style='padding: 15px; background: "+ (message.from_client ? "#D4EFDF" : "#F2F3F4") +";'>"
                                +message.message
                            +"<span>"
                        +"</div>"
                    +"</div>"
                );
                containerTalk[0].scrollTo(0, containerTalk[0].scrollHeight);
            }
            if (managersIds.includes(messageManager.id)) {
                let message = data.message;
                let messageManagerElement = jQuery("#message_manager_" + messageManager.id);
                messageManagerElement.empty().append(
                    "<div class='left'>"
                        +"<i class='fa fa-circle'></i>"
                    +"</div>"
                    +"<div class='right'>"
                        +"<h3>" + message.from + "</h3>"
                        +"<p>" + message.message + "</p>"
                    +"</div>"
                )
            } else {
                if (managersIds.length == 0) {
                    messageManagerContainer.empty();
                }
                let message = data.message;
                managersIds.push(messageManager.id);
                messageManagerContainer.append(
                    "<div id='message_manager_"+messageManager.id+"' class='mail_list message-manager' style='cursor: pointer' data-id='"+messageManager.id+"'>"
                        +"<div class='left'>"
                            +"<i class='fa fa-circle'></i>"
                        +"</div>"
                        +"<div class='right'>"
                            +"<h3>" + message.from + "</h3>"
                            +"<p>" + message.message + "</p>"
                        +"</div>"
                    +"</div>"
                );
            }
            jQuery(".mail_list").off().click(function() {
                let messageManagaerId = jQuery(this).data("id");
                App.room.send({ action: "check_new_messages", body: messageManagaerId});
            });
            break;
        }
        case "finalize" : {
            let container = jQuery("#messages_container");
            let messageManagerContainer = jQuery("#message_managers_container");
            let messageManager = data.message_manager;
            let messageManagerElement = jQuery("#message_manager_" + messageManager.id);
            messageManagerElement.remove();
            if (container.length > 0 && messageManager.id == container.data("id")) {
                container.empty();
                container.append("<h3>Nenhuma conversa para mostrar</h3>");
            }
            let index = managersIds.indexOf(messageManager.id);
            if (index > -1) {
                managersIds.splice(index, 1);
                container.data("id", null);
            }
            if (managersIds.length == 0) {
                messageManagerContainer.append("<h3>Sem threads</h3>");
            }
            break;
        }
    }
}

function connected() {
    App.room.send({ action: "check_new_managers"});
}