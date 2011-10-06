# Feature: Manage recipes
#   In order to [goal]
#   [stakeholder]
#   wants [behaviour]
#
#   Scenario: Register new recipe
#     Given I am on the new recipe page
#     When I fill in "recipe_title" with "title 1"
#     And I fill in "Bake temperature" with "bake_temperature 1"
#     And I fill in "Preparation" with "preparation 1"
#     And I press "Create"
#     Then I should see "title 1"
#     And I should see "bake_temperature 1"
#     And I should see "preparation 1"
#
#   Scenario: Delete recipe
#     Given the following recipes:
#       |title|bake_temperature|preparation|
#       |title 1|bake_temperature 1|preparation 1|
#       |title 2|bake_temperature 2|preparation 2|
#       |title 3|bake_temperature 3|preparation 3|
#       |title 4|bake_temperature 4|preparation 4|
#     When I delete the 3rd recipe
#     Then I should see the following recipes:
#       |title|bake_temperature|preparation|
#       |title 1|bake_temperature 1|preparation 1|
#       |title 2|bake_temperature 2|preparation 2|
#       |title 4|bake_temperature 4|preparation 4|
