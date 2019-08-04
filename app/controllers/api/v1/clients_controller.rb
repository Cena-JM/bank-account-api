# frozen_string_literal: true

module Api
  module V1
    class ClientsController < ApplicationController
      def index
        @clients = Client.all
        json_response(@clients)
      end

      def show
        @client = Client.find(params[:id])
        @bank_accounts = @client.bank_accounts.order('created_at DESC')
        json_response([@client, ['accounts', @bank_accounts]])
      end

      def new
        @client = Client.new
      end

      def create
        @client = Client.create(client_params)
        if @client.save
          json_response(@client, :created)
        else
          json_response(@client, :unprocessable_entity)
        end
      end

      def destroy
        @client = Client.find(params[:id])
        @client.destroy
        head :no_content
      end

      def update
        @client = Client.find(params[:id])
        @client.update(client_params)
        head :no_content
      end

      private

      def client_params
        params.permit(
          :first_name,
          :last_name,
          :middle_name,
          :address,
          :gender,
          :date_of_birth,
          :email,
          :client_number
        )
      end
    end
  end
end
