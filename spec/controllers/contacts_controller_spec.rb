require 'rails_helper'

describe ContactsController do
  describe 'GET #intex' do
    context 'with params[:letter]' do
      it 'populate an array of contacts starting with the letter' do
        # get :index, 's'
        # expect(response).to have_http_status 200
      end

      it 'renders the :index template' do
        # get :index,
      end
    end

    context 'without params' do
      it 'populate an array of all contacts' do
      end

      it 'renders the :index template' do

      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested contact to @contact' do
    end

    it 'renders the :show template' do
    end
  end

  describe 'GET #new' do
    it 'assigns a new contact to @contact' do

    end

    it 'renders the :new template' do

    end
  end

  describe 'POST #create' do
    context 'with valid attribute' do
      it 'saves the new contact on database' do

      end

      it 'redirect to contacts#show' do
        post :create, contact: FactoryGirl.attributes_for(:contact)
        expect(response).to have_http_status 302
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new contact to database' do

      end

      it 're-render the :new template' do

      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        it 'update the contact on database' do

        end

        it 'redirects to the contact' do

        end
      end

      context 'with invalid attributes' do
        it 'does not update contact' do

        end

        it 're-renders the #edit template' do

        end
      end
    end

    describe 'DELETE #destory' do
      it 'delete contact from database' do

      end

      it 'redirect to contacts#index' do

      end
    end
  end
end
