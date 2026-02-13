# frozen_string_literal: true

require_relative "integration_helper"

RSpec.describe "Statements", :integration do
  include WikidataAdaptor::Integration::Helpers

  describe "item statements" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @item = create_item!(labels: { "en" => "Stmts item #{SecureRandom.hex(4)}" })
      @string_property = create_property!(
        data_type: "string",
        labels: { "en" => "Stmts string prop #{SecureRandom.hex(4)}" }
      )
    end

    describe "#get_item_statements" do
      it "returns a hash of statements (empty for a new item)" do
        result = api_client.get_item_statements(@item["id"]).parsed_content

        expect(result).to be_a(Hash)
        expect(result).to be_empty
      end
    end

    describe "#post_item_statement" do
      it "creates a statement on an item and returns it" do
        payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "test value" }
          },
          "comment" => "integration test"
        }
        result = api_client.post_item_statement(@item["id"], payload).parsed_content

        expect(result["id"]).to match(/\A#{@item["id"]}\$/)
        expect(result["rank"]).to eq("normal")
        expect(result["property"]["id"]).to eq(@string_property["id"])
        expect(result["value"]["content"]).to eq("test value")
      end
    end

    describe "#patch_item_statement" do
      it "patches a statement on an item and returns it" do
        create_payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "original patch value" }
          },
          "comment" => "integration test: create for patch"
        }
        created = api_client.post_item_statement(@item["id"], create_payload).parsed_content
        stmt_id = created["id"]

        patch_payload = {
          "patch" => [{ "op" => "replace", "path" => "/value/content", "value" => "patched item value" }],
          "comment" => "integration test: patch"
        }
        result = api_client.patch_item_statement(@item["id"], stmt_id, patch_payload).parsed_content

        expect(result["id"]).to eq(stmt_id)
        expect(result["value"]["content"]).to eq("patched item value")
      end
    end

    describe "#put_item_statement" do
      it "replaces a statement on an item and returns it" do
        create_payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "original value" }
          },
          "comment" => "integration test: create for put"
        }
        created = api_client.post_item_statement(@item["id"], create_payload).parsed_content
        stmt_id = created["id"]

        put_payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "replaced value" }
          },
          "comment" => "integration test: put"
        }
        result = api_client.put_item_statement(@item["id"], stmt_id, put_payload).parsed_content

        expect(result["id"]).to eq(stmt_id)
        expect(result["value"]["content"]).to eq("replaced value")

        fetched = api_client.get_item_statement(@item["id"], stmt_id).parsed_content
        expect(fetched["value"]["content"]).to eq("replaced value")
      end
    end
  end

  describe "property statements" do
    before(:context) do
      extend WikidataAdaptor::Integration::Helpers

      @property = create_property!(labels: { "en" => "Stmts prop #{SecureRandom.hex(4)}" })
      @string_property = create_property!(
        data_type: "string",
        labels: { "en" => "Stmts string prop 2 #{SecureRandom.hex(4)}" }
      )
    end

    describe "#get_property_statements" do
      it "returns a hash of statements (empty for a new property)" do
        result = api_client.get_property_statements(@property["id"]).parsed_content

        expect(result).to be_a(Hash)
        expect(result).to be_empty
      end
    end

    describe "#post_property_statement" do
      it "creates a statement on a property and returns it" do
        payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "test value" }
          },
          "comment" => "integration test"
        }
        result = api_client.post_property_statement(@property["id"], payload).parsed_content

        expect(result["id"]).to match(/\A#{@property["id"]}\$/)
        expect(result["rank"]).to eq("normal")
        expect(result["property"]["id"]).to eq(@string_property["id"])
        expect(result["value"]["content"]).to eq("test value")
      end
    end

    describe "#patch_property_statement" do
      it "patches a statement on a property and returns it" do
        create_payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "original patch prop value" }
          },
          "comment" => "integration test: create for patch"
        }
        created = api_client.post_property_statement(@property["id"], create_payload).parsed_content
        stmt_id = created["id"]

        patch_payload = {
          "patch" => [{ "op" => "replace", "path" => "/value/content", "value" => "patched prop value" }],
          "comment" => "integration test: patch"
        }
        result = api_client.patch_property_statement(@property["id"], stmt_id, patch_payload).parsed_content

        expect(result["id"]).to eq(stmt_id)
        expect(result["value"]["content"]).to eq("patched prop value")
      end
    end

    describe "#patch_statement" do
      it "patches a statement by global statement_id and returns it" do
        create_payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "original global patch value" }
          },
          "comment" => "integration test: create for patch_statement"
        }
        created = api_client.post_property_statement(@property["id"], create_payload).parsed_content
        stmt_id = created["id"]

        patch_payload = {
          "patch" => [{ "op" => "replace", "path" => "/value/content", "value" => "patched global value" }],
          "comment" => "integration test: patch_statement"
        }
        result = api_client.patch_statement(stmt_id, patch_payload).parsed_content

        expect(result["id"]).to eq(stmt_id)
        expect(result["value"]["content"]).to eq("patched global value")
      end
    end

    describe "#put_property_statement" do
      it "replaces a statement on a property and returns it" do
        create_payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "original prop value" }
          },
          "comment" => "integration test: create for put"
        }
        created = api_client.post_property_statement(@property["id"], create_payload).parsed_content
        stmt_id = created["id"]

        put_payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "replaced prop value" }
          },
          "comment" => "integration test: put"
        }
        result = api_client.put_property_statement(@property["id"], stmt_id, put_payload).parsed_content

        expect(result["id"]).to eq(stmt_id)
        expect(result["value"]["content"]).to eq("replaced prop value")

        fetched = api_client.get_property_statement(@property["id"], stmt_id).parsed_content
        expect(fetched["value"]["content"]).to eq("replaced prop value")
      end
    end

    describe "#put_statement" do
      it "replaces a statement by global statement_id and returns it" do
        create_payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "original global value" }
          },
          "comment" => "integration test: create for put_statement"
        }
        created = api_client.post_property_statement(@property["id"], create_payload).parsed_content
        stmt_id = created["id"]

        put_payload = {
          "statement" => {
            "property" => { "id" => @string_property["id"] },
            "value" => { "type" => "value", "content" => "replaced global value" }
          },
          "comment" => "integration test: put_statement"
        }
        result = api_client.put_statement(stmt_id, put_payload).parsed_content

        expect(result["id"]).to eq(stmt_id)
        expect(result["value"]["content"]).to eq("replaced global value")

        fetched = api_client.get_statement(stmt_id).parsed_content
        expect(fetched["value"]["content"]).to eq("replaced global value")
      end
    end
  end
end
