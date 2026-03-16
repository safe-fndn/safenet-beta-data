.PHONY: fix
fix:
	find assets/ -name '*.json' -exec sh -c \
		'jq --tab --sort-keys . "{}" > "{}.tmp" && mv "{}.tmp" "{}"' ';'
