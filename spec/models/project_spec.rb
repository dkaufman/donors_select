require 'spec_helper'

describe "Project" do
  context "fetching projects from DonorsChoose" do
    describe ".build_uri" do
      it "builds a valid URI when no params are specified" do
        uri = Project.build_uri
        uri.should == "http://api.donorschoose.org/common/json_feed.html?max=20&APIKey=DONORSCHOOSE"
      end

      it "builds a valid URI when params are specified" do
        params = ["gradeType=3"]
        uri = Project.build_uri(params)
        uri.should == "http://api.donorschoose.org/common/json_feed.html?max=20&APIKey=DONORSCHOOSE&gradeType=3"
      end
    end

    describe ".find_by" do
      context "and the query has not been cached" do

        before(:each) do
          Project.stub(:fetch_from).and_return nil
        end

        it "returns nil" do
          results = Project.find_by(["gradeType=3"])
          results.should be nil
        end
      end

      context "and the query has been cached" do
        before(:each) do
          Project.stub(:fetch_from).and_return serve_response(:projects)
        end

        it "returns the cached projects" do
          results = Project.find_by(["gradeType=3"])
          results["proposals"].should_not be nil
        end
      end
    end

    describe ".fetch_and_publish" do
      let(:uri) { Project.build_uri(["state=MN"]) }

      it "calls queue job with the uri and token" do
        Project.should_receive(:queue_job).with(uri, "123")
        Project.fetch_and_publish(["state=MN"], "123")
      end
    end

    describe ".queue_job" do
      let(:uri) { Project.build_uri(["state=MN"]) }

      it "calls Resque.enqueue with the uri and token" do
        Resque.should_receive(:enqueue).with(Fetcher, uri, "123")
        Project.queue_job(uri, "123")
      end
    end

    describe ".fetch_from(uri)" do
      let(:uri) { Project.build_uri(["state=MN"]) }

      it "calls redis.get with the uri" do
        Redis.any_instance.should_receive(:get).with(uri)
        Project.fetch_from(uri)
      end
    end
  end
end
