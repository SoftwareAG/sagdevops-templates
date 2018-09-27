<!-- Copyright 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors

   SPDX-License-Identifier: Apache-2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and

     limitations under the License.                                                  

-->

# Hello world

Use this template to confirm you can run and test templates in your development environment.

## Requirements

### Supported Software AG releases

* Command Central 10.3 and higher

### Supported platforms

All supported Windows and UNIX platforms.

## Testing the template

See [Testing existing templates](https://github.com/SoftwareAG/sagdevops-templates/wiki/Testing-existing-templates)

Run provision wrapper script from the root of the project:

```bash
./provisionw hello-world
```

Notice the log output includes a line that looks like this:

```bash
2018/09/21 20:32:23 INFO  #119   hello: exit code: 0 std out: ************** Hello World! ***************
```

Run provision wrapper and pass a parameter:

```bash
./provisionw hello-world hello.name=There
```

Notice the log ouput changes:

```bash
2018/09/21 20:32:23 INFO  #119   hello: exit code: 0 std out: ************** Hello There! ***************
```

## Applying the template

See [Applying template using Command Central CLI](https://github.com/SoftwareAG/sagdevops-templates/wiki/Using-default-templates#applying-template-using-command-central-cli)
