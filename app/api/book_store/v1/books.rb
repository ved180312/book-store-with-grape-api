# frozen_string_literal: true

module BookStore
  module V1
    class Books < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :books do
        desc 'create a new book'
        params do
          requires :isbn, type: String
          requires :title, type: String
          requires :stock, type:  Integer
        end
        post do
          Book.create!({ isbn:params[:isbn], title:params[:title], stock:params[:stock]})
        end

        desc 'Return list of books'
        get do
          books = Book.all
          present books
        end

        desc 'Update all books'
        route_param :id do
          put do
            Book.find(params[:id]).update({ isbn:params[:isbn], title:params[:title], stock:params[:stock] })
          end
        end

        desc 'Return a specific book'
        route_param :id do
          get do
            book = Book.find(params[:id])
            present book
          end
          get '/flows' do
            book = Book.find(params[:id])
            flows = book.flows
            present flows
          end
          params do 
            requires :previousStock, type: Integer
            requires :newStock, type: Integer
          end
          post '/flows' do
            book = Book.find(params[:id])
            flow = book.flows.create!({ previousStock:params[:previousStock], newStock:params[:newStock]})
            present flow
          end
                    
        end

        desc 'Delete a specific book'
        route_param :id do
          delete do
            book = Book.find(params[:id])
            book.destroy
          end
        end

      end
    end
  end
end
