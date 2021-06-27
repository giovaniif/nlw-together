defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "giovani", email: "giovani@adopets.org", password: "123123"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: ^params,
        errors: [],
      } = response
    end

    test "when an invalid name is provided, returns an error" do
      params = %{name: "g", email: "giovani@adopets.org", password: "123123"}

      response = User.changeset(params)
      expected_response = %{
        name: ["should be at least 2 character(s)"]
      }

      assert errors_on(response) == expected_response
    end

    test "when an invalid email is provided, returns an error" do
      params = %{name: "giovani", email: "giovani", password: "123123"}

      response = User.changeset(params)
      expected_response = %{
        email: ["has invalid format"]
      }

      assert errors_on(response) == expected_response
    end

    test "when an invalid password is provided, returns an error" do
      params = %{name: "giovani", email: "giovani@adopets.org", password: "1234"}

      response = User.changeset(params)
      expected_response = %{
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
