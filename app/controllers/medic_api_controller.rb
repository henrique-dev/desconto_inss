class MedicApiController < ApplicationController
    before_action :authenticate_medic!
end