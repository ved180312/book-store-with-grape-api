# frozen_string_literal: true

module BookStore
  module V1
    class Flows < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :flows do

        desc 'create a new flow'
        params do
          requires :previousStock, type: Integer
          requires :newStock, type: Integer
          requires :book_id, type: Integer
        end
        post do
          Flow.create!({ previousStock:params[:previousStock], newStock:params[:newStock], book_id:params[:book_id]})
        end

        desc 'Return list of flows'
        get do
          flows = Flow.all
          present flows
        end

        desc 'Update a specific book'
        route_param :id do
          put do
            Flow.find(params[:id]).update({ previousStock:params[:previousStock], newStock:params[:newStock], book_id:params[:book_id]})
          end
        end


        desc 'Return a specific flow'
        route_param :id do
          get do
            flow = Flow.find(params[:id])
            present flow
          end
        end

        desc 'Delete a specific flow'
        route_param :id do
          delete do
            flow = Flow.find(params[:id])
            flow.destroy
          end
        end

      end
    end
  end
end
  
  
  