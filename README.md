# dotbproj
A systemd service boot kit for starting vagrant VM or docker containers on system boot

This is Ubuntu-based, tested with Ubuntu 20.04 LTS. However, I would expect it works with other Debian-based OS distributions.

If you experience a bug, please file an issue so others can help or submit your PR. Thank you!

## *WARNING!*
This project is currently used for projects I am working on. It may not work on your projects. Lot of changes need to be made and document here. However, if you're interested in, you're welcome to change and submit your PR. I welcome contributors. Thank you so much!

## Usage
### For your project
When you just want to use it for create systemd.service for starting your project
1. Download `dotbproj`. This step will clone this repo and place `.bproj` folder in your project folder and clean its other codes.
```bash
cd /myproject # Jump to your project folder, change this path to your project path
git clone https://github.com/Rp70/dotbproj.git dotbproj # Clone this repo
mv dotbproj/.bproj ./ # Move the .bproj to your project folder
rm -rdf dotbproj # Clean up the cloned repo
```
2. Create `project.env` in your project folder. There is a `sample.project.env` you can copy
```bash
cp .bproj/sample.project.env project.env
```
3. Custom `project.env` to meet your needs. Editors like `vi` or `nano` would help:
* If `vi` is available, run `vi project.env`
* If `nano` is available, run `nano project.env`
4. Install your systemd.service by running:
* Under `root`
```bash
ENVRONMENT=prod HOST=rp70 .bproj/support/install.sh
```
* Under `sudo` account
```bash
ENVRONMENT=prod HOST=rp70 sudo .bproj/support/install.sh
```
Replace `rp70` with your own name.

### For development of this `dotbproj`
When you fix bug or want to contribute your code, do as followings:
[The instructions will be here later]


## TODO
- [ ] Plugins system so it works with other softwares and other devs can join.


