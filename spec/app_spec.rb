require_relative 'spec_helper'

class AppSpec < PokedexAppSpec
  describe '/' do
    let(:result) { get '/' }

    it 'handles the request' do
      assert_equal 200, result.status
    end

    it 'displays a pokemon' do
      get '/'
      assert last_response.ok?
      assert_equal true, last_response.body.include?('pokemon')
    end
  end
end
