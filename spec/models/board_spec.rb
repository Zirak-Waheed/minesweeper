require 'rails_helper'

RSpec.describe Board, type: :model do
  subject(:board) { FactoryBot.build(:board) }

  describe 'validations' do
    context 'when name is not present' do
      before { board.name = nil }

      it 'is not valid' do
        expect(board).not_to be_valid
      end
    end

    context 'when email is not present' do
      before { board.email = nil }

      it 'is not valid' do
        expect(board).not_to be_valid
      end
    end

    context 'when length is not greater than 0' do
      before { board.length = 0 }

      it 'is not valid' do
        expect(board).not_to be_valid
      end
    end

    context 'when width is not greater than 0' do
      before { board.width = 0 }

      it 'is not valid' do
        expect(board).not_to be_valid
      end
    end

    context 'when mines is not greater than 0' do
      before { board.mines = 0 }

      it 'is not valid' do
        expect(board).not_to be_valid
      end
    end


    context 'validates mines count' do
      subject(:board) { FactoryBot.build(:board, length: 10, width: 10, mines: mines) }

      let(:mines) { 50 }

      context 'when mines count is less than or equal to the total number of cells' do
        it 'does not add any validation errors' do
          board.validate
          expect(board.errors[:mines]).to be_empty
        end
      end

      context 'when mines count is greater than the total number of cells' do
        let(:mines) { 110 }

        it 'adds a validation error' do
          board.validate
          expect(board.errors[:mines]).to include("can't be greater than total number of cells")
        end
      end
    end
  end

  describe 'before create' do
    context 'should populate state' do
      let(:board_1) { FactoryBot.create(:board) } 
      let(:board_2) { FactoryBot.create(:board) }

      it 'with correct number of mines' do
        board.mines = 15
        board.save
        expect(board.state.flatten.count(-1)).to eq(15)
      end      

      it 'with distinct pattern' do
        expect(board_1.state.size).to eq(board_2.state.size)
        expect(board_1.state.flatten.count(-1)).to eq(board_2.state.flatten.count(-1))
        expect(board_1.state).not_to eq(board_2.state)
      end
    end
  end
end
