define ['chaplin'], (Chaplin) ->
  'use strict'

  # The application object
  # Choose a meaningful name for your application
  class JoatuApplication extends Chaplin.Application
    # Create aditional mediator properties
    # ------------------------------------
    initMediator: ->
      # Create a user property
      Chaplin.mediator.user = null

      # This is used by the modal view
      # to ensure only one modal displays
      # at a time.
      Chaplin.mediator.modal = null

      # Create an api_base_url property
      # Chaplin.mediator.api_base_url = configs().api_base_url
      Chaplin.mediator.api_base_url = "http://local.api.joatu.com"

      # Seal the mediator
      Chaplin.mediator.seal()
