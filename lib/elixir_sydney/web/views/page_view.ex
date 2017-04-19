defmodule ElixirSydney.Web.PageView do
  use ElixirSydney.Web, :view

  def markdown_to_html(markdown) do
    {:safe, Earmark.as_html!(markdown)}
  end

  def short_date(date) do
    Timex.format!(date, "{Mfull} {YYYY}")
  end

  def long_date(date) do
    Timex.format!(date, "{WDfull}, {D} {Mfull} {YYYY}")
  end

  def meetup_time do
    "6:00pm - 8:30pm"
  end

  def short_month(date) do
    Timex.format!(date, "{Mshort}")
  end

  def json_ld_for_meetups(meetups, opts \\ [pretty: true]) do
    {:safe, """
    <script type="application/ld+json">
      #{meetups |> Enum.map(&to_ld_json(&1)) |> Poison.encode!(opts)}
    </script>
    """}
  end

  defp to_ld_json(meetup) do
    %{
      "@context": "http://schema.org",
      "@type": "Event",
      "name": meetup.title,
      "description": meetup.description,
      "url": meetup.url,
      "startDate": meetup.date,
      "endDate": meetup.date,
      "location": %{
        "@type": "Place",
        "name": "Pivotal Labs",
        "address": %{
          "@type": "PostalAddress",
          "streetAddress": "11/155 Clarence Street",
          "addressLocality": "Sydney",
          "addressRegion": "NSW",
          "postalCode": "2000",
          "addressCountry": "Australia"
        }
      }
    }
  end

end
