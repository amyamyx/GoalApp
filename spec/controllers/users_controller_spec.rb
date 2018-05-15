# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'renders the new users template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'logs in the user' do
        post :create, params: { user: { username: 'harry', password: 'abcdef'} }
        user = User.find_by(username: 'harry')
        expect(session[:session_token]).to eq(user.session_token)
      end

      it 'redirects to user show page' do
        post :create, params: { user: { username: 'harry', password: 'abcdef'} }
        user = User.find_by(username: 'harry')
        expect(response).to redirect_to( user_url(user) )
      end
    end

    context 'with invalid params' do
      it 'renders new template' do
        post :create, params: { user: { username: 'harry', password: ''} }
        expect(response).to render_template(:new)
      end

      it 'flashes error messages' do
        post :create, params: { user: { username: 'harry', password: ''} }
        expect(flash[:errors]).to be_present
      end

    end
  end

  describe 'GET #index' do
    it 'renders users index page'

  end

  describe 'GET #show' do
    it 'renders users show page'
  end


end
