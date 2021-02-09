require 'rails_helper'

describe Parser::UniqueLogResults do
  subject { described_class }

  let(:sort_by) { %w(ASC DESC) }

  let(:log_file) { 'spec/test_log.log' }

  describe 'Get top unique log results' do

    context 'When sort param is passed and is DESC' do
      subject { described_class.new( path: log_file, sort: 'DESC' ).call }

      it 'returns array of hashes with pages and their unique view count in DESC order' do
        expect(subject).to eq(
            [{:count=>5, :page=>"/help_page/1"},
             {:count=>3, :page=>"/home"},
             {:count=>1, :page=>"/about"},
             {:count=>1, :page=>"/about/2"},
             {:count=>1, :page=>"/index"},
             {:count=>1, :page=>"/contact"}]
        )
      end
    end

    context 'When sort param is passed and is ASC' do 
      subject { described_class.new( path: log_file, sort: 'ASC' ).call }

      it 'returns array of hashes with pages and their unique view count in ASC order' do
        expect(subject).to eq(
            [{:count=>1, :page=>"/contact"},
             {:count=>1, :page=>"/index"},
             {:count=>1, :page=>"/about/2"},
             {:count=>1, :page=>"/about"},
             {:count=>3, :page=>"/home"},
             {:count=>5, :page=>"/help_page/1"}]
        )
      end
    end
  end
end