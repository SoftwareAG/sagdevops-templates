#!/bin/sh
#*******************************************************************************
#  Copyright © 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors
#
#   SPDX-License-Identifier: Apache-2.0
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.                                                            
#
#*******************************************************************************

echo -e "\n"
echo "####################"
echo "# Inventory Report #"
echo "####################"
echo -e "\n"

echo -e "\n### Installed Command Central products:"
sagcc list inventory products nodeAlias=local properties=product.displayName,product.version.string
echo -e "\n### Installed Command Central fixes:"
sagcc list inventory fixes nodeAlias=local properties=fix.displayName,fix.version

echo -e "\n### Registered PRODUCT repos:"
sagcc list repository products properties="*"

echo -e "\n### Registered FIX repos:"
sagcc list repository fixes properties="*"

echo -e "\n### Registered ASSET repos:"
sagcc list repository assets properties="*"

echo -e "\n### Registered lisense KEYS:"
sagcc list license-tools keys properties="*"

echo -e "\n### Registered NODES:"
sagcc list landscape nodes properties="*"

echo -e "\n### Registered TEMPLATES:"
sagcc list templates composite

echo -e "\n\n### END of report"
echo "####################"
echo -e "\n\n"
