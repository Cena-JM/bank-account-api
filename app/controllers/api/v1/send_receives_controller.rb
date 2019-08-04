# frozen_string_literal: true

module Api
  module V1
    class SendReceivesController < ApplicationController
      def index
        @send_receives = SendReceive.all
        json_response(@send_receives)
      end

      def show
        @send_receive = SendReceive.find(params[:id])
        @sender = @send_receive.sender.client
        @receiver = @send_receive.receiver.client
        json_response([@send_receive.amount, ['sender', @sender], ['receiver', @receiver]])
      end
    end
  end
end
