KUBECONFIG="$HOME/.kube/config"
export KUBECONFIG

update-kubeconfig() {
	KUBECONFIG="$HOME/.kube/config"
	if test -d "$HOME/.kube/config.d"
	then
		for config in "$HOME/.kube/config.d"/*.yaml
		do
			test -r "$config" && KUBECONFIG="$KUBECONFIG:$config"
		done
		unset config
	fi
}

update-kubeconfig
