# github_mac_notifications

A hacked-together Ruby script that polls the GitHub API to check for notifications and displays them in OS X Notification Center.

# Install and setup

```
  $ bundle install
  $ cp config/config-example.yml config/config.yml
```

Edit your `config.yml` to match your own Github credentials.

And that's it!

# Run

The main entry point is through `bin/run`.

You can do something like the following to run this thing in the background:
```
  $ bin/run &> log/log &
```

# FAQ

## This thing is useless, why didn't you use XYZNotifier?

I should have. But I was unable to find XYZNotifier due to lack of Google-fu. TELL ME YOUR SECRETS.
