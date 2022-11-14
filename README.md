# dotbproj
A systemd service boot kit for starting vagrant VM or docker containers on system boot

This is Ubuntu-based, tested with Ubuntu 20.04 LTS. However, I would expect it works with other Debian-based OS distributions.

If you experience a bug, please file an issue so others can help or submit your PR. Thank you!

## *WARNING!*
This project is currently used for projects I am working on. It may not work on your projects. Lot of changes need to be made and document here. However, if you're interested in, you're welcome to change and submit your PR. I welcome contributors. Thank you so much!

## Usage
### For your project
When you just want to use it for create systemd.service for starting your project. Installation & Upgrade processes have the same steps.
1. Change working directory to your project
```bash
cd /myproject # Jump to your project folder, CHANGE this path to your project path
```
**CHANGE** this path to your project path
2. One-command installation `dotbproj`. This step will clone this repo and place `.bproj` folder in your project folder and clean its other codes.

**WARNING!** This will remove existing `.bproj` and install the latest version.
**WARNING!** Make sure that you review https://raw.githubusercontent.com/Rp70/dotbproj/master/install-bproj.sh before running on your machine. Do not trust me.
```bash
curl -s https://raw.githubusercontent.com/Rp70/dotbproj/master/install-bproj.sh | bash -
```
3. Upgrade process ends here. If this is the very first installation, continue the below instructions.
4. Create `project.env` in your project folder. There is a `sample.project.env` you can copy
```bash
cp .bproj/sample.project.env project.env
```
5. Custom `project.env` to meet your needs. Editors like `vi` or `nano` would help:
* If `vi` is available, run `vi project.env`
* If `nano` is available, run `nano project.env`
6. Install your systemd.service by running:
* Under `root`
```bash
ENVRONMENT=prod HOST=`hostname` .bproj/support/install.sh
```
* Under `sudo` account
```bash
sudo ENVRONMENT=prod HOST=`hostname` .bproj/support/install.sh
```
Replace `rp70` with your own name.

### For development of this `dotbproj`
When you fix bug or want to contribute your code, do as followings:
[The instructions will be here later]


## TODO
- [ ] Plugins system so it works with other softwares and other devs can join.


