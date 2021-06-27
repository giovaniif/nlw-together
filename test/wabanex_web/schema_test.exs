defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users query" do
    test "when a valid id is given, return the user", %{conn: conn} do
      params = %{email: "giovani@adopets.org", name: "Giovani", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_result = %{"data" => %{"getUser" => %{"email" => "giovani@adopets.org", "id" => user_id, "name" => "Giovani"}}}

      assert expected_result == response
    end
  end

  describe "users mutations" do
    test "when all params are valid, create the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Giovani",
            email: "giovani@adopets.org",
            password: "123456"
          }) {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      expected_result = %{"data" => %{"createUser" => %{"email" => "giovani@adopets.org", "name" => "Giovani"}}}

      assert expected_result == response
    end
  end
end
