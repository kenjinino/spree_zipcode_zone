$ ->
  ($ '#country_based').click ->
    show_country()

  ($ '#state_based').click ->
    show_state()

  ($ '#zipcode_range_based').click ->
    show_zipcode_range()

  if ($ '#country_based').is(':checked')
    show_country()
  else if ($ '#state_based').is(':checked')
    show_state()
  else if ($ '#zipcode_range_based').is(':checked')
    show_zipcode_range()
  else
    show_state()
    ($ '#state_based').click()


show_country = ->
  ($ '#state_members :input').each ->
    ($ this).prop 'disabled', true

  ($ '#state_members').hide()
  ($ '#zone_members :input').each ->
    ($ this).prop 'disabled', true

  ($ '#zone_members').hide()
  ($ '#zipcode_range_members :input').each ->
    ($ this).prop 'disabled', true

  ($ '#zipcode_range_members').hide()
  ($ '#country_members :input').each ->
    ($ this).prop 'disabled', false

  ($ '#country_members').show()

show_state = ->
  ($ '#country_members :input').each ->
    ($ this).prop 'disabled', true

  ($ '#country_members').hide()
  ($ '#zone_members :input').each ->
    ($ this).prop 'disabled', true

  ($ '#zone_members').hide()
  ($ '#zipcode_range_members :input').each ->
    ($ this).prop 'disabled', true

  ($ '#zipcode_range_members').hide()
  ($ '#state_members :input').each ->
    ($ this).prop 'disabled', false

  ($ '#state_members').show()

show_zipcode_range = ->
  ($ '#country_members :input').each ->
    ($ this).prop 'disabled', true

  ($ '#country_members').hide()
  ($ '#zone_members :input').each ->
    ($ this).prop 'disabled', true

  ($ '#zone_members').hide()
  ($ '#state_members :input').each ->
    ($ this).prop 'disabled', true

  ($ '#state_members').hide()
  ($ '#zipcode_range_members :input').each ->
    ($ this).prop 'disabled', false

  ($ '#zipcode_range_members').show()
