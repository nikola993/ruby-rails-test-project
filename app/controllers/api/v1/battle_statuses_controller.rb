module Api
  module V1
    class BattleStatusesController < ApplicationController
      def index
        @status = BattleStatus.where(battle_id: params[:battle_id]).first
        render json: @status
      end
    end
  end
end
