require 'rails_helper'

describe ContactsController do

  shared_examples 'public access to contacts' do
    describe 'GET #intex' do
      before(:each) do
        @ted = create(:contact, lastname: 'ted')
        @salma = create(:contact, lastname: 'salma')
        @santo = create(:contact, lastname: 'santo')
      end

      context 'with params[:letter]' do
        it 'populate an array of contacts starting with the letter' do
          get :index, letter: 's'
          expect(assigns(:contacts)).to match_array([@salma, @santo])
        end

        it 'renders the :index template' do
          get :index, letter: 's'
          expect(response).to render_template :index
        end
      end

      context 'without params' do
        it 'populate an array of all contacts' do
          get :index
          expect(assigns(:contacts)).to match_array([@salma, @santo, @ted])
        end

        it 'renders the :index template' do
          get :index
          expect(response).to render_template :index
        end
      end
    end

    describe 'GET #show' do
      before(:each) do
        @salma = create(:contact)
      end

      it 'assigns the requested contact to @contact' do
        get :show, id: @salma
        expect(assigns(:contact)).to eq @salma
      end

      it 'renders the :show template' do
        get :show, id: @salma
        expect(response).to render_template :show
      end
    end
  end

  shared_examples 'full access to contacts' do
    describe 'GET #new' do
      it 'assigns a new contact to @contact' do
        get :new, contact: attributes_for(:contact)
        expect(assigns(:contact)).to be_a_new(Contact)
      end

      it 'renders the :new template' do
        get :new, contact: attributes_for(:contact)
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'with valid attribute' do
        it 'saves the new contact on database' do
          expect{
            post :create, contact: attributes_for(:contact)
          }.to change(Contact, :count).by(1)
        end

        it 'redirect to contacts#show' do
          post :create, contact: attributes_for(:contact)
          expect(response).to have_http_status 302
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new contact to database' do
          expect{
            post :create, contact: attributes_for(:invalid_contact)
          }.to_not change(Contact, :count)
        end

        it 're-render the :new template' do
          post :create, contact: attributes_for(:invalid_contact)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      before do
        @contact = create(:contact)
      end

      context 'with valid attributes' do
        it 'assign the contact to @contact' do
          patch :update, id: @contact, contact: attributes_for(:contact, lastname: 'sumon')
          expect(assigns(:contact)).to eq @contact
        end

        it 'update the contact on database' do
          patch :update, id: @contact,
                contact: attributes_for(:contact, firstname: 'hasanuzzaman',
                                        lastname: 'sumon')
          @contact.reload
          expect(@contact.firstname).to eq 'hasanuzzaman'
          expect(@contact.lastname).to eq 'sumon'
        end

        it 'redirects to the contact' do
          patch :update, id: @contact, contact: attributes_for(:contact, lastname: 'sumon')
          expect(response).to redirect_to contact_path(@contact)
        end
      end

      context 'with invalid attributes' do
        it 'does not update contact' do
          patch :update, id: @contact,
                contact: attributes_for(:contact, firstname: 'hasanuzzaman',
                                        lastname: nil)
          @contact.reload
          expect(@contact.firstname).to_not eq 'hasanuzzaman'
        end

        it 're-renders the #edit template' do
          patch :update, id: @contact, contact: attributes_for(:contact, lastname: nil)
          expect(response).to render_template(:edit)
        end
      end
    end


    describe 'DELETE #destory' do
      before do
        @contact = create :contact
      end

      it 'delete contact from database' do
        expect{
          delete :destroy, id: @contact
        }.to change(Contact, :count).by(-1)
      end

      it 'redirect to contacts#index' do
        delete :destroy, id: @contact
        expect(response).to redirect_to contacts_path
      end
    end
  end

  describe 'administrator access' do
    before do
      admin = create(:admin)
      login(admin)
    end

    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'

  end

  describe 'member access' do
    before do
      user = create(:user)
      login(user)
    end
    it_behaves_like 'public access to contacts'
    it_behaves_like 'full access to contacts'
  end

  describe 'guest access' do
    it_behaves_like 'public access to contacts'
  end
end
