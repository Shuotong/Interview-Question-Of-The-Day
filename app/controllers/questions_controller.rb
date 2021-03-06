class QuestionsController < ApplicationController

  def init 
    require 'rest_client'
    @response = RestClient.get 'https://www.kimonolabs.com/api/2tepoq7s?apikey=i4ShqnRlMKnYLTe9oGyIOyef9ybz0Qnp'
    @json = JSON.parse @response
    @questions = @json["results"]["Questions"]

    @questions.each do |q|
      if q["Content"]["text"].length == 0
        next
      end
      @question = Question.new
      @question.content = q["Content"]["text"]

      @question.source_url = q["Content"]["href"]
      @question.vote_count = 0
      @question.save!
    end
  end
  
  def index
#    @questions = Question.all
    @questions = Question.paginate(:page => params[:page], :per_page => 3)
  end

  def show
    @question = Question.find(params[:id])
    @today_num = Date.today.cwday
    @today_name = ""
    case @today_num
    when 1
      @today_name = "Monday"
      @today_question = @question_M
    when 2
      @today_name = "Tuesday"
      @today_question = @question_T
    when 3
      @today_name = "Wednesday"
      @today_question = @question_W
    when 4
      @today_name = "Thursday"
      @today_question = @question_TT
    when 5
      @today_name = "Friday"
      @today_question = @question_F
    when 6
      @today_name = "Saturday"
      @today_question = @question_S							
    when 7
      @today_name = "Sunday"
      @today_question = @question_SS
    end

  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def scrape
  end

  def today_question
    @today_num = Date.today.cwday
    @today_name = ""
    @today_question = nil


    @question_M = Question.find(VisitorsController.getRandom[0])
    @question_T = Question.find(VisitorsController.getRandom[1])
    @question_W = Question.find(VisitorsController.getRandom[2])
    @question_TT = Question.find(VisitorsController.getRandom[3])
    @question_F = Question.find(VisitorsController.getRandom[4])
    @question_S = Question.find(VisitorsController.getRandom[5])
    @question_SS = Question.find(VisitorsController.getRandom[6])

    case @today_num
    when 1
      @today_name = "Monday"
      @today_question = @question_M
    when 2
      @today_name = "Tuesday"
      @today_question = @question_T
    when 3
      @today_name = "Wednesday"
      @today_question = @question_W
    when 4
      @today_name = "Thursday"
      @today_question = @question_TT
    when 5
      @today_name = "Friday"
      @today_question = @question_F
    when 6
      @today_name = "Saturday"
      @today_question = @question_S							
    when 7
      @today_name = "Sunday"
      @today_question = @question_SS
    end
  end

end
