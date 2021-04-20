# Cadence chart upgrade guide

## Table of contents

- [I. General strategies](#I.-General-strategies)
- [II. Gather the upstream changes (if applicable)](#II.-Gather-the-upstream-changes-(if-applicable))
- [III. Determine the new chart version](#III.-Determine-the-new-chart-version)
- [IV. Change the chart](#IV.-Change-the-chart)
- [V. Test the changes](#V.-Test-the-changes)
- [VI. Integrate the changes and release the new chart
  version](#VI.-Integrate-the-changes-and-release-the-new-chart-version)

## I. General strategies

- We aim to provide charts supporting the latest available Cadence server
  version, down to the patch semantic part.

- We also intend to provide charts supporting all minor versions available
  between the latest **chart supported** server version and the latest
  **available** server version.

  This means gradual chart releases - by latest patch of any minor version in
  between - when multiple new server minor versions are **available** compared
  to the latest **chart supported** server version.

- If there is both

   - an available server version with no supporting chart yet, and
   - an independent chart change to be done not related to the upstream components,

  at the same time, please incorporate these changes into two different chart
  version releases as a safety measure.

  Available server versions **SHOULD** take precedence unless the chart change
  is aiming to fix a serious issue with the general usability of the chart.

_There can be occasional, reasonable exceptions to these general rules, when
necessary due to circumstances._

## II. Gather the upstream changes (if applicable)

Note: for chart-only changes not involving any changes in upstream references
(for example changing chart default values, but not changing server version),
section II. should be skipped.

1. Check the available [Cadence server
   tags](https://github.com/uber/cadence/tags).

   If there is a **server version** to upgrade to, pick the latest available
   patch version of the chosen minor version.

   **Reminder**: according to the general strategy, in case multiple minor or
   major **server versions** had been released since the last **chart version**,
   please upgrade gradually, by the latest patch version of each minor version
   between the latest **chart supported** server version and the latest
   **available** server version.

2. Note down any potential minor or major (breaking) change between the last
   **chart supported** server version and the chosen next server version.
   Breaking changes are usually listed as notes or breaking changes at the
   upstream tag description.

3. Go through the changes (consider PR- or commit-wise) and look for changes to
   the chart/input interface and output/behavior (and also keep an eye out for
   undocumented minor/major changes). Keep a reference of anything that might
   require a chart value change (new configuration options, changed defaults,
   etc.).

   This can be overwhelming at first, but the main focus should be on the public
   API's libraries and binaries (and the public interface of those) with an
   emphasis on the static configuration.

## III. Determine the new chart version

[Note: major version 0.Minor.Patch may contain breaking changes in any version
change.](https://semver.org/#spec-item-4) However it is general practice to
reserve patch versions for patch changes only and use the minor versions for
breaking changes of major version 0.Minor.Patch.

1. From the gathered server changes, form a short summary of the chart related
   minor and major (breaking) changes.

2. Determine the new **chart version**.

   a, **In case of a chart-only change (no upstream reference change)**,
   determine the necessary **chart version change** based on the relation of the
   change to the chart's public interface according to [semantic versioning
   rules](https://semver.org/spec/v2.0.0.html).

   b, **In case of a server version upgrade**, use the **server version change**
   (patch, minor or major) and apply the same kind of semantic version change to
   the last **chart version** to obtain the base of the new **chart version**.
   If stronger semantic changes are implied to the chart than to the **server
   version**, use the chart change's semantic scope (e.g. major - breaking -
   change on the chart's public interface takes precedence over a minor server
   version change and so on).

   **The chart and server versions are not kept in sync** as of now, but they do
   reflect the scope of the strongest semantic version change between two
   versions.

## IV. Change the chart

1. Check out a new branch from the latest remote HEAD of the default branch.

2. In case of changing the server version:

   1. update the required version at the [`Prerequisites` section of the
      `cadence/README.md`](../README.md#Prerequisites)'s to the new **server
      version**,

   2. Also update the default value of the [`Configuration / server.image.tag`
      parameter in the `cadence/README.md`](../README.md#Configuration) to the
      new **server version**,

   3. update the chart's default application version at the [`appVersion` field
      in the `cadence/Chart.yaml`](../Chart.yaml)'s to the new **server
      version**,

   4. update the image tag version at the [`server.image.tag` field in the
      `cadence/values.yaml`](../values.yaml)'s, to the new **server version**

3. Update the chart's version at the [`version` field in the
   `cadence/Chart.yaml`](../Chart.yaml)'s to the newly determined **chart
   version**,

4. **If there are any minor or major (breaking) changes affecting the chart,
   update the chart files accordingly to incorporate those changes.** Make sure
   these updates to the chart are collected and ready to be listed for
   reference.

## V. Test the changes

Testing can be done in any environment utilizing the main features of the
Cadence chart, server and client.

Optionally, you may use a [Banzai Cloud
Pipeline](https://github.com/banzaicloud/pipeline) Kind cluster instance via the
[banzai CLI](https://github.com/banzaicloud/banzai-cli) to test the changes. You
**MUST** have an account at a supported cloud provider in order to use this
method.

1. Choose an unused Pipeline workspace name, or reuse a previous workspace name
   (for example `cadence-chart-upgrade`) and export the name and the workspace
   paths derived from it.

   ```shell
   export BANZAI_INSTALLER_WORKSPACE_NAME="cadence-chart-upgrade"
   export BANZAI_INSTALLER_WORKSPACE="${HOME}/.banzai/pipeline/${BANZAI_INSTALLER_WORKSPACE_NAME}"
   ```

2. **If you have no Pipeline control plane workspace set up for testing**
   (otherwise you may use your existing workspace), you can initialize one the
   following way:

   a, Generate the initial workspace configuration.

   ```shell
   banzai pipeline init --provider kind --workspace ${BANZAI_INSTALLER_WORKSPACE}
   ```
   (for the following steps you **MAY** use the [yq CLI Yaml
   processor](https://github.com/mikefarah/yq).)

   b, Save the workspace values YAML file's location for reuse.

   ```shell
   export BANZAI_INSTALLER_WORKSPACE_VALUES="${BANZAI_INSTALLER_WORKSPACE}/values.yaml"
   ```

   b, You **MUST** set up a
   [CloudInfo](https://github.com/banzaicloud/cloudinfo/) instance to be used
   for test cluster creation. Currently there is no publicly available hosted
   instance, but you **MAY** host one yourself.

   ```shell
   yq eval ".pipeline.configuration.cloudinfo.endpoint = \"${YOUR_CLOUDINFO_INSTANCE_ENDPOINT}\"" "${BANZAI_INSTALLER_WORKSPACE_VALUES}" --inplace
   ```

   c, You **MAY** change the workspace `values.yaml` 's ` installer.image` value
   to `banzaicloud/pipeline-installer:latest` so it always uses the latest
   available tag, automatically keeping it up to date.

   ```shell
   yq eval ".installer.image = \"$(yq eval .installer.image ${BANZAI_INSTALLER_WORKSPACE_VALUES} | sed -E 's/banzaicloud\/pipeline\-installer\@sha256\:.+/banzaicloud\/pipeline\-installer\:latest/g')\"" "${BANZAI_INSTALLER_WORKSPACE_VALUES}" --inplace
   ```

   d, You **MAY** also change the Kind cluster name to a unique one to avoid
   name clashing.

   ```shell
   yq eval ".providerConfig.cluster_name = \"${BANZAI_INSTALLER_WORKSPACE_NAME}-control-plane\"" "${BANZAI_INSTALLER_WORKSPACE_VALUES}" --inplace
   ```

   After these modifications, the `values.yaml` file in your workspace **MAY**
   look like the following:

   ```shell
   defaultStorageBackend: mysql
   externalHost: default.localhost.banzaicloud.io
   ingressHostPort: true
   installer:
      image: banzaicloud/pipeline-installer:latest
   provider: kind
   tlsInsecure: true
   uuid: ${UUID}
   providerConfig:
      cluster_name: cadence-chart-upgrade-control-plane
   pipeline:
   configuration:
      cloudinfo:
         endpoint: ${URL}
   ```

3. Set up the Kind control plane cluster.

   ```shell
   banzai pipeline up --workspace ${BANZAI_INSTALLER_WORKSPACE}
   ```

4. When prompted, log in to the CLI using the offered browser method. You should
   use the generated static credentials written to the output of the CLI
   command.

5. Use the Kind cluster's Kubernetes configuration.

   ```shell
   export BANZAI_INSTALLER_WORKSPACE_KUBECONFIG="${BANZAI_INSTALLER_WORKSPACE}/.kube/config"
   ```

6. Check and wait for the cadence pods (frontend, history, matching, worker) to
   be running.

   ```shell
   watch kubectl --kubeconfig "${BANZAI_INSTALLER_WORKSPACE_KUBECONFIG}" --namespace banzaicloud get pods --selector "app.kubernetes.io/instance=cadence"
   ```

7. Check the currently deployed Cadence **server version**.

   ```shell
   kubectl --kubeconfig "${BANZAI_INSTALLER_WORKSPACE_KUBECONFIG}" --namespace banzaicloud get pods --selector "app.kubernetes.io/instance=cadence" --output yaml |    grep -E "^\s+image: [^ ]+$"
   ```

   It is expected to output something like `      image:
   ubercadence/server:Major.Minor.Patch`.

8. If the deployed server version is not the [latest chart supported server
   version](https://github.com/banzaicloud/banzai-charts/blob/master/cadence/Chart.yaml#L3),
   deploy the latest chart.

   ```shell
   helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com
   helm repo update
   helm upgrade --debug --install --kubeconfig "${BANZAI_INSTALLER_WORKSPACE_KUBECONFIG}" --namespace banzaicloud cadence banzaicloud-stable/cadence
   ```

9. If the upgrade finishes successfully, wait for the old pods being terminated
   and for the new ones transferring to running state.

   ```shell
   watch kubectl --kubeconfig "${BANZAI_INSTALLER_WORKSPACE_KUBECONFIG}" --namespace banzaicloud get pods --selector "app.kubernetes.io/instance=cadence"
   ```

10. Check the Cadence server version to be the latest chart supported one.

    ```shell
    kubectl --kubeconfig "${BANZAI_INSTALLER_WORKSPACE_KUBECONFIG}" --namespace banzaicloud get pods --selector "app.kubernetes.io/instance=cadence" --output yaml | grep -E "^\s+image: \S+$"
    ```

11. Create a cluster.

    ```shell
    banzai secret create
    banzai cluster create --name "${BANZAI_INSTALLER_WORKSPACE_NAME}-pre" --file ...
    watch banzai cluster list
    ```

12. Using your local branch, upgrade the Cadence Helm chart of the control plane
    to the new server version you are testing.

    ```shell
    helm dep build cadence # where ${PWD} == local banzaicloud/banzai-charts repository.
    helm upgrade --debug --install --kubeconfig "${BANZAI_INSTALLER_WORKSPACE_KUBECONFIG}" --namespace banzaicloud cadence ./cadence
    ```

13. If the upgrade finishes successfully, wait for the old pods being terminated
    and for the new ones transferring to running state.

    ```shell
    watch kubectl --kubeconfig "${BANZAI_INSTALLER_WORKSPACE_KUBECONFIG}" --namespace banzaicloud get pods --selector "app.kubernetes.io/instance=cadence"
    ```

14. Check the Cadence server version to be the new one.

    ```shell
    kubectl --kubeconfig "${BANZAI_INSTALLER_WORKSPACE_KUBECONFIG}" --namespace banzaicloud get pods --selector "app.kubernetes.io/instance=cadence" --output yaml | grep -E "^\s+image: [^ ]+$"
    ```

15. Start creating a new cluster

    ```shell
    banzai cluster create --name "${BANZAI_INSTALLER_WORKSPACE_NAME}-post" --file ...
    ```

16. Upgrade the previously existing cluster's node pool. Wait for it to finish
    and observe its successful completion.

    ```shell
    banzai cluster nodepool list --cluster-name "${BANZAI_INSTALLER_WORKSPACE_NAME}-pre"
    banzai cluster nodepool upgrade pool1 --cluster-name "${BANZAI_INSTALLER_WORKSPACE_NAME}-pre" --file ...
    banzai cluster nodepool list --cluster-name "${BANZAI_INSTALLER_WORKSPACE_NAME}-pre"
    ```

17. Delete the old cluster

    ```shell
    banzai cluster delete --cluster-name "${BANZAI_INSTALLER_WORKSPACE_NAME}-pre"
    ```

18. Wait for the old cluster to be deleted and the new to be created.

    ```shell
    watch banzai cluster list
    ```

19. When the new cluster is created perform a node pool upgrade on it, wait for
    its completion and observe its success.

    ```shell
    banzai cluster nodepool list --cluster-name "${BANZAI_INSTALLER_WORKSPACE_NAME}-post"
    banzai cluster nodepool upgrade pool1 --cluster-name "${BANZAI_INSTALLER_WORKSPACE_NAME}-post" --file ...
    banzai cluster nodepool list --cluster-name "${BANZAI_INSTALLER_WORKSPACE_NAME}-post"
    ```

20. Delete the new cluster and wait for it to be deleted.

    ```shell
    banzai cluster delete --cluster-name "${BANZAI_INSTALLER_WORKSPACE_NAME}-post"
    watch banzai cluster list
    ```

21. Tear down the Kind control plane cluster.

    ```shell
    banzai pipeline down --workspace ${BANZAI_INSTALLER_WORKSPACE}
    ```

## VI. Integrate the changes and release the new chart version

1. Commit your changes and open a PR to the default branch. Fill the description
   with the relevant information, especially regarding minor and major changes.

2. Merge the PR.

3. Check out the default branch, fetch the remote and reset the local default
   branch to the latest remote HEAD.

4. Tag the HEAD commit for the new Cadence chart with the tag schema
   `cadence/Major.Minor.Patch`, check it to point to the correct commit and have
   the expected description (highlighting breaking changes), then push it to the
   remote. You **MAY** draft a GitHub release from the new tag.
