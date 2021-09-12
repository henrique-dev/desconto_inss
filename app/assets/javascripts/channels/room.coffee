App.room = App.cable.subscriptions.create "AdminChannel",  
  connected: ->    
    connected();
    console.log('Conectado');
  received: (data) ->
    dataReceived(data);
    console.log(data);