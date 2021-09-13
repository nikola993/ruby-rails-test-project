# frozen_string_literal: true

module Api
  module V1
    # Controller for battle
    class BattlesController < ApplicationController
      before_action :sanitize_page_params

      def index
        battles = Battle.includes(:armies)

        battles_data = []
        battles.each do |battle|
          battles_data.push({ battle: battle, armies: battle.armies })
        end

        render json: battles_data
      end

      def show
        battle = Battle.includes(:armies).find(params[:id])
        if battle
          render json: { battle: battle, armies: battle.armies }
        else
          render josn: { error: battle.errors, message: 'battle doesn not exist' }, status: 400
        end
      end

      def create
        battle = Battle.new(battle_params)
        battle.status = 0
        battle.battle_status = BattleStatus.new

        if battle.save
          render json: battle
        else
          render json: { error: battle.errors, message: 'Unable to create battle' }, status: 400
        end
      end

      def update
        battle = Battle.includes(:armies).find(params[:id])
        render josn: { error: battle.errors, message: 'Not found' }, status: 404 unless battle
        response = BattleService.new(battle).start_battle

        if response[:error]
          render json: response, status: 400
        else
          render json: response, status: 200
        end
      end

      private

      def sanitize_page_params
        params[:status] = params[:status].to_i
      end

      def battle_params
        params.permit(:battle_id)
      end
    end
  end
end
