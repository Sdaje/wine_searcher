require 'rails_helper'

RSpec.describe BottlesController, type: :request do

  describe 'GET index' do
    subject { get root_path }

    it { subject && expect(response).to(have_http_status(:ok)) }
  end
end
