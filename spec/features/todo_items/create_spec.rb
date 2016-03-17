require 'spec_helper'

describe "Adding todo items" do
  let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list.") }

  it "is successful with valid content" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"

    fill_in "Content", with: "Milk"
    click_button "Save"

    expect(page).to have_content("Added todo list item.")
    within("ul.todo_items") do
      expect(page).to have_content("Milk")
    end
  end

  it "displays an error with no content" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"

    fill_in "Content", with: ""
    click_button "Save"

    within("div.alert") do
      expect(page).to have_content("There was a problem adding that todo list item.")
    end

    expect(page).to have_content("Content can't be blank")
  end

  it "displays an error with when content is less than 2 characters long" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"

    fill_in "Content", with: "z"
    click_button "Save"

    within("div.alert") do
      expect(page).to have_content("There was a problem adding that todo list item.")
    end

    expect(page).to have_content("Content is too short")
  end
end
