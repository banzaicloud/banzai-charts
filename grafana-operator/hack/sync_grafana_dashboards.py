#!/usr/bin/env python3
"""Fetch dashboards from provided urls into this chart."""
import json
import textwrap
from os import makedirs, path

import requests
import yaml
from yaml.representer import SafeRepresenter


# https://stackoverflow.com/a/20863889/961092
class LiteralStr(str):
    pass


def change_style(style, representer):
    def new_representer(dumper, data):
        scalar = representer(dumper, data)
        scalar.style = style
        return scalar

    return new_representer


# Source files list
charts = [
    {
        'source': 'https://raw.githubusercontent.com/coreos/kube-prometheus/master/manifests/grafana-dashboardDefinitions.yaml',
        'destination': '../templates/dashboards',
        'type': 'yaml',
        'min_kubernetes': '1.14.0-0',
        'prefix': 'kube-prometheus_'
    },
    {
        'source': 'https://raw.githubusercontent.com/etcd-io/etcd/master/Documentation/op-guide/grafana.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': ''
    },
    {
        'source': 'https://raw.githubusercontent.com/banzaicloud/logging-operator/master/config/dashboards/logging-dashboard.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': ''
    },
    {
        'source': 'https://raw.githubusercontent.com/banzaicloud/thanos-operator/master/dashboards/bucket-replicate.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': 'thanos_'
    },
    {
        'source': 'https://raw.githubusercontent.com/banzaicloud/thanos-operator/master/dashboards/compact.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': 'thanos_'
    },
    {
        'source': 'https://raw.githubusercontent.com/banzaicloud/thanos-operator/master/dashboards/overview.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': 'thanos_'
    },
    {
        'source': 'https://raw.githubusercontent.com/banzaicloud/thanos-operator/master/dashboards/query.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': 'thanos_'
    },
    {
        'source': 'https://raw.githubusercontent.com/banzaicloud/thanos-operator/master/dashboards/receive.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': 'thanos_'
    },
    {
        'source': 'https://raw.githubusercontent.com/banzaicloud/thanos-operator/master/dashboards/rule.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': 'thanos_'
    },
    {
        'source': 'https://raw.githubusercontent.com/banzaicloud/thanos-operator/master/dashboards/sidecar.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': 'thanos_'
    },
    {
        'source': 'https://raw.githubusercontent.com/banzaicloud/thanos-operator/master/dashboards/store.json',
        'destination': '../templates/dashboards',
        'type': 'json',
        'min_kubernetes': '1.14.0-0',
        'prefix': 'thanos_'
    },
]

# Additional conditions map
condition_map = {
    'etcd': '.Values.defaultDashboards.etcd',
    'apiserver': '.Values.defaultDashboards.apiserver',
    'controller-manager': '.Values.defaultDashboards.controller_manager',
    'kubelet': '.Values.defaultDashboards.kubelet',
    'cluster-total': '.Values.defaultDashboards.cluster_total',
    'proxy': '.Values.defaultDashboards.proxy',
    'scheduler': '.Values.defaultDashboards.scheduler',
    'namespace-by-pod': '.Values.defaultDashboards.namespace_by_pod',
    'namespace-by-workload': '.Values.defaultDashboards.namespace_by_workload',
    'node-rsrc-use': '.Values.defaultDashboards.node_rsrc_use',
    'k8s-resources-node': '.Values.defaultDashboards.k8s_resources_node',
    'k8s-resources-namespace': '.Values.defaultDashboards.k8s_resources_namespace',
    'k8s-resources-cluster': '.Values.defaultDashboards.k8s_resources_cluster',
    'k8s-resources-pod': '.Values.defaultDashboards.k8s_resources_pod',
    'k8s-resources-workload': '.Values.defaultDashboards.k8s_resources_workload',
    'k8s-resources-workloads-namespace': '.Values.defaultDashboards.k8s_resources_workloads_namespace',
    'k8s-resources-workloads-pod': '.Values.defaultDashboards.k8s_resources_workloads_pod',
    'nodes': '.Values.defaultDashboards.nodes',
    'persistentvolumesusage': '.Values.defaultDashboards.persistentvolumesusage',
    'pod-total': '.Values.defaultDashboards.pod_total',
    'prometheus': '.Values.defaultDashboards.prometheus',
    'statefulset': '.Values.defaultDashboards.statefulset',
    'workload-total': '.Values.defaultDashboards.workload_total',
    'node-cluster-rsrc-use': '.Values.defaultDashboards.node_cluster_rsrc_use',
    'prometheus-remote-write': '.Values.defaultDashboards.prometheus.prometheusSpec.remoteWriteDashboards',
    'logging-dashboard': '.Values.defaultDashboards.logging_dashboard',
    'bucket-replicate': '.Values.defaultDashboards.thanos.bucket_replicate',
    'compact': '.Values.defaultDashboards.thanos.compact',
    'overview': '.Values.defaultDashboards.thanos.overview',
    'query': '.Values.defaultDashboards.thanos.query',
    'receive': '.Values.defaultDashboards.thanos.receive',
    'rule': '.Values.defaultDashboards.thanos.rule',
    'sidecar': '.Values.defaultDashboards.thanos.sidecar',
    'store': '.Values.defaultDashboards.thanos.store',
}

# standard header
header = '''{{- /*
Generated from '%(name)s' from %(url)s
Do not change in-place! In order to change this file first read following link:
https://github.com/banzaicloud/banzai-charts/tree/master/grafana-operator/hack

This script is based on: https://github.com/helm/charts/tree/master/stable/prometheus-operator/hack great works thanks!

*/ -}}
{{- if and .Values.defaultDashboards.enabled %(condition)s.enabled }}

apiVersion: integreatly.org/v1alpha1
kind: GrafanaDashboard
metadata:
  name: {{ printf "%%s-%%s" (include "grafana-operator.fullname" $) "%(name)s" | trunc 63 | trimSuffix "-" }}
  labels: {{- include "grafana-operator.labels" . | nindent 8 }}
spec:
  name: {{ printf "%%s-%%s" (include "grafana-operator.fullname" $) "%(name)s" | trunc 63 | trimSuffix "-" }}
  {{- if %(condition)s.plugins }}
  plugins:
    {{- toYaml %(condition)s.plugins | nindent 8 }}
  {{- end }}
'''

def init_yaml_styles():
    represent_literal_str = change_style('>', SafeRepresenter.represent_str)
    yaml.add_representer(LiteralStr, represent_literal_str)


def escape(s):
    return s.replace("{{", "{{`{{").replace("}}", "}}`}}").replace("{{`{{", "{{`{{`}}").replace("}}`}}", "{{`}}`}}")


def yaml_str_repr(struct, indent=2):
    """represent yaml as a string"""
    text = yaml.dump(
        struct,
        width=1000,  # to disable line wrapping
        default_flow_style=False  # to disable multiple items on single line
    )
    text = escape(text)  # escape {{ and }} for helm
    text = textwrap.indent(text, ' ' * indent)
    return text


def write_group_to_file(resource_name, content, url, destination, min_kubernetes, max_kubernetes, prefix):
    # initialize header
    lines = header % {
        'name': resource_name,
        'var_name': resource_name.replace('-','_'),
        'url': url,
        'condition': condition_map.get(resource_name, ''),
        'min_kubernetes': min_kubernetes,
        'max_kubernetes': max_kubernetes,
        'prefix': prefix
    }

    filename_struct = {'json': (LiteralStr(content))}
    # rules themselves
    lines += yaml_str_repr(filename_struct)

    # footer
    lines += '{{- end }}'

    filename = prefix + resource_name + '.yaml'
    new_filename = "%s/%s" % (destination, filename)

    # make sure directories to store the file exist
    makedirs(destination, exist_ok=True)

    # recreate the file
    with open(new_filename, 'w') as f:
        f.write(lines)

    print("Generated %s" % new_filename)


def main():
    init_yaml_styles()
    # read the rules, create a new template file per group
    for chart in charts:
        print("Generating rules from %s" % chart['source'])
        response = requests.get(chart['source'])
        if response.status_code != 200:
            print('Skipping the file, response code %s not equals 200' % response.status_code)
            continue
        raw_text = response.text

        if ('max_kubernetes' not in chart):
            chart['max_kubernetes']="9.9.9-9"

        if chart['type'] == 'yaml':
            yaml_text = yaml.full_load(raw_text)
            groups = yaml_text['items']
            for group in groups:
                for resource, content in group['data'].items():
                    write_group_to_file(resource.replace('.json', ''), content, chart['source'], chart['destination'], chart['min_kubernetes'], chart['max_kubernetes'], chart['prefix'])
        elif chart['type'] == 'json':
            json_text = json.loads(raw_text)
            # is it already a dashboard structure or is it nested (etcd case)?
            flat_structure = bool(json_text.get('annotations'))
            if flat_structure:
                resource = path.basename(chart['source']).replace('.json', '')
                write_group_to_file(resource, json.dumps(json_text, indent=4), chart['source'], chart['destination'], chart['min_kubernetes'], chart['max_kubernetes'], chart['prefix'])
            else:
                for resource, content in json_text.items():
                    write_group_to_file(resource.replace('.json', ''), json.dumps(content, indent=4), chart['source'], chart['destination'], chart['min_kubernetes'], chart['max_kubernetes'], chart['prefix'])
    print("Finished")


if __name__ == '__main__':
    main()
