defmodule AppAdmin.User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "users" do
        field :first_name, :string
        field :last_name, :string
        field :middle_name, :string
        field :email, :string
        field :phone_number, :string
    end

    @required_fields ~w(first_name last_name email phone_number)a
    @optional_fields ~w(middle_name)a

    def changeset(user, params) do
        user
        |> cast(params, @required_fields ++ @optional_fields)
        |> validate_required(@required_fields)
        |> validate_email(:email)
        |> validate_phone(:phone_number)
    end

    # https://gist.github.com/daemonfire300/b6705a9ce103a8bf3f70c755350ac683
    @mail_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/
    # ensure that the email looks valid
    defp validate_email(changeset, field) do
        changeset
        |> validate_format(field, @mail_regex)
    end 
  
    # https://en.wikipedia.org/wiki/List_of_country_calling_codes#Alphabetical_listing_by_country_or_region
    # https://en.wikipedia.org/wiki/Telephone_numbering_plan
    # us only for starters
    @phone_regex ~r/^\+1\d{10}$/
    defp validate_phone(changeset, field) do
        changeset
        |> validate_format(field, @phone_regex)
    end
end