using Genie.Renderer.Html

function billgatesbooks()
  [
    Html.h1() do
      "Bill Gates' list of recommended books"
    end
    Html.ul() do
      for_each(BillGatesBooks) do book
        Html.li() do
          book.title * " by " * book.author
        end
      end
    end
  ]
end