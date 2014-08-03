require 'helper'

def generate_cursor
  Feedlr::Cursor.new(request_attributes)
end

describe Feedlr::Cursor do
  let(:client) { Feedlr::Client.sandbox }
  let(:params) { { two: 2 } }
  let(:request_attributes) do
    { client: client,
      path: '/something',
      method: :get,
      headers: { one: 1 },
      params: params }
  end
  describe '#last_page?' do
    it 'returns true if so' do
      cursor = generate_cursor
      cursor.send(:continuation=, nil)
      expect(cursor.last_page?).to eq(true)
    end

    it 'returns false if not' do
      cursor = generate_cursor
      expect(cursor.last_page?).to eq(false)
    end
  end

  describe '#next_page?' do
    it 'returns true if so' do
      cursor = generate_cursor
      expect(cursor.next_page?).to eq(true)
    end

    it 'returns false if not' do
      cursor = generate_cursor
      cursor.send(:continuation=, nil)
      expect(cursor.next_page?).to eq(false)
    end
  end

  describe '#next_page' do
    let(:cursor) { generate_cursor }
    let(:continuation) { 'ssfs' }
    let(:request_response) do
      double(body: { a: 1, b: 2, continuation: continuation })
    end

    before :each do
      allow(cursor).to receive(:perform_request)
      .and_return(request_response)
    end

    it 'returns nil if there are no more pages' do
      cursor.send(:continuation=, nil)
      expect(cursor.next_page).to eq(nil)
    end

    it 'performs a request' do
      expect(cursor).to receive(:perform_request)
      cursor.next_page
    end

    it 'creates an object' do
      allow(Feedlr::Factory).to receive(:create)
      .with(request_response.body).and_return(double(continuation: nil))
      expect(Feedlr::Factory).to receive(:create)
      .with(request_response.body)
      cursor.next_page
    end

    it 'sets the new continuation' do
      cursor.next_page
      expect(cursor.send(:continuation)).to eq(continuation)
    end

    it 'returns the response factory' do
      expect(cursor.next_page)
      .to eq(Feedlr::Base.new(request_response.body))
    end

  end

  describe '#each_page' do
    let(:cursor) { generate_cursor }

    it 'should return an enumerator if no block is provided' do
      expect(cursor.each_page).to be_an(Enumerator)
    end

    it 'yields till no more pages' do
      request_responses = [
        double(body: { a: 1, b: 2, continuation: '1232' }),
        double(body: { c: 3, d: 4, continuation: '4567' }),
        double(body: { e: 5, f: 6 })
      ]
      allow(cursor).to receive(:perform_request)
      .and_return(request_responses[0])
      expect(cursor).to receive(:perform_request).exactly(4).times

      cursor.each_with_index do |_, index|
        allow(cursor).to receive(:perform_request)
        .and_return(request_responses[index])
      end

    end

  end

  describe '#perform_request' do
    let(:cursor) { generate_cursor }
    let(:continuation) { 'ssfs' }
    it 'creates a request with the request_attributes and the ' \
    'current continuation' do
      cursor.send(:continuation=, continuation)
      ra = request_attributes.clone
      ra[:params] = params.clone.merge!(continuation: continuation)
      request = double(perform: 'nothing')
      allow(Feedlr::Request).to receive(:new).and_return(request)
      expect(Feedlr::Request).to receive(:new).with(ra)
      cursor.send(:perform_request)
    end

    it 'performs it' do
      request = double
      allow(Feedlr::Request).to receive(:new).and_return(request)
      expect(request).to receive(:perform)
      cursor.send(:perform_request)
    end

  end

end
