# frozen_string_literal: true

module Api
  module V1
    # Controller for battle
    class BattlesController < ApplicationController
      before_action :sanitize_page_params

      def index
        battles = Battle.includes(:armies).references(:posts)

        battles_data = []
        battles.each do |battle|
          battles_data.push({ battle: battle, armies: battle.armies })
        end

        render json: battles_data
      end

      def show
        battle = Battle.find(params[:id])
        armies = Army.where(battle: battle)
        render json: { battle: battle, armies: armies }
      end

      def create
        battle = Battle.new(battle_params)

        if battle.save
          render json: battle
        else
          render json: { error: battle.errors }, status: 400
        end
      end

      def update
        battle = Battle.includes(:armies).find(params[:id])
        render josn: { error: battle.errors, message: 'Not found' }, status: 404 unless battle

        BattleService.start_battle(battle)

        if battle
          render json: { battle: battle, message: 'Battle started' }, status: 200
        else
          render josn: { error: battle.errors }, status: 400
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
