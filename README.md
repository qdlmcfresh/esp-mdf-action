# esp-mdf-action

GitHub action to build ESP-MDF project using esp-mdf framework. This action downloads the required ESP-MDF from espressif server and from github for latest branch. `v2` introduced cache esp-mdf and its tools based on esp-mdf version

Set the `esp_mdf_version` as follows
- `latest` (master branch)
- [ESP-MDF version list](https://github.com/espressif/esp-mdf/tags)

or specify a commit with `esp_mdf_commit`


**Note:**
The action runs on ubuntu latest and python3 as default interpreter.

### Example
```yml
# This is a esp mdf workflow to build ESP32 based project

name: Build and Artifact the ESP-MDF Project

# Controls when the action will run. 
on:
  # Triggers the workflow on tag create like v1.0, v2.0.0 and so on
  push:
    tags:
     - 'v*'

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest
    steps:
    - name: Install ESP-MDF and Build project
      uses: qdlmcfresh/esp-mdf-action@v3.0
      with: 
          esp_mdf_version: 'v1.0'
          esp_mdf_target: 'esp32'
          #token: ${{ secrets.TOKEN }}
          #submodules: 'recursive' set to true or 'recursive' if you need submodules

    - name: Archive build output artifacts
      uses: actions/upload-artifact@v2
      with:
        name: build
        path: |
          build/bootloader/bootloader.bin
          build/partition_table/partition-table.bin
          build/${{ github.event.repository.name }}.bin

```

## Test

Currently this action is verified with esp-mdf v1.0

## License

This repository is licensed with the [MIT License](LICENSE).