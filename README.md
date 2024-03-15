# A quick install script for setting up a collaborative obsidian vault locally

Obsidian-sync is an install and configuration script to run the couchdb of [vrtmz's Self-hosted LiveSync](https://github.com/vrtmrz/obsidian-livesync/).

## Download and use

`Soon`

## Setup the client plugin to use obsidian collaboratively

In order to work on the same remote vault everyone wanting to takes notes with will have to log as the same user and to the same couchdb as you.

In this example, this is our credentials :

- user : test_user
- password : test
- database name : test_db
- URI : `http://192.168.1.117:5984`

> [!IMPORTANT]
> On the client side you will have to ask someone for the credentials, theses won't work.

First start the plugins wizard in the settings tab, and press `start` for the minimal setup.

![The settings tab](./imgs/wizard_launch.png)

Then this is where you will put the credentials.

![Connection to the database](./imgs/wizard_credentials.png)

> [!TIP]
> You can press the button `check` to see if you are connected to the couchdb database.

Then you can pass this pannel, i will give you a configuration i like later.

![Sync setup](./imgs/wizard_sync.png)

## My personnal "Sync Settings" to work with others


Go to the plugin's settings and cick on the sync tab (the 5th from the left).

- Sync Mode => <strong style="color: purple;">"Periodic and On events"</strong>
- Periodic Sync interval => <strong style="color: purple;">5</strong>
- Sync on Save => <strong style="color: red;">Off</strong>
- Sync on Editor Save => <strong style="color: green;">On</strong>
- Sync on File Open => <strong style="color: green;">On</strong>
- Sync on Start => <strong style="color: green;">On</strong>
- Sync after merging => <strong style="color: red;">Off</strong>
`----------------------------------------------------------`
- Use the trash bin => <strong style="color: green;">On</strong>
- Keep empty folder => <strong style="color: red;">Off</strong>
`----------------------------------------------------------`
- Always overwrite with a newer file => <strong style="color: green;">On</strong>
- Postpone resolution of inactive files => <strong style="color: red;">Off</strong>
- Postpone manual resolution of inactive files => <strong style="color: red;">Off</strong>



![My sync settings](./imgs/config_sync.png)


