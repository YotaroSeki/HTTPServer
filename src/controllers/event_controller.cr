class EventController < ApplicationController
  def index
    events = {events: Event.all}
    respond_with 200 do
      json events.to_json
    end
  end

  def show
    if event = Event.find params["id"]
      respond_with 200 do
        json event.to_json
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def create
    event = Event.new
    params = event_params.validate!
    event.title = params["title"]
    event.memo = params["memo"]
    event.deadline = Time.parse_local(params["deadline"].not_nil!, "%F")

    if event.valid? && event.save
      results = {status: "success", message: "registered", id: event.id}
      respond_with 200 do
        json results.to_json
      end
    end

  rescue
    results = {"status": "failure", "message": "invalid data format"}
    respond_with 400 do
      json results.to_json
    end
  end

  def update
    if event = Event.find(params["id"])
      event.set_attributes(event_params.validate!)
      if event.valid? && event.save
        respond_with 200 do
          json event.to_json
        end
      else
        results = {status: "invalid"}
        respond_with 422 do
          json results.to_json
        end
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def destroy
    if event = Event.find params["id"]
      event.destroy
      respond_with 204 do
        json ""
      end
    else
      results = {status: "not found"}
      respond_with 404 do
        json results.to_json
      end
    end
  end

  def event_params
    params.validation do
      required(:deadline, msg: nil, allow_blank: false)
      required(:title, msg: nil, allow_blank: false)
      required(:memo, msg: nil, allow_blank: true)
    end
  end
end
