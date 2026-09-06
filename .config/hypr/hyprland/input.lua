hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",

    follow_mouse = 1,

    repeat_rate = 30,
    repeat_delay = 300,

    touchpad = {
      disable_while_typing = false,
      natural_scroll = true,
      scroll_factor = 0.5,
      clickfinger_behavior = true,
    },
  },
})

hl.device({
  name = "tpps/2-elan-trackpoint",
  sensitivity = 0.25,
  scroll_factor = 0.6,
})

-- Enable-disable trackpad
hl.device({
  name = "snsl002d:00-2c2f:002d-touchpad",
  enabled = true,
})

hl.device({
  name = "wacom-one-by-wacom-s-pen",
  output = "eDP-1",
})
