class PatientApiController < ApplicationController
    before_action :authenticate_patient!
end