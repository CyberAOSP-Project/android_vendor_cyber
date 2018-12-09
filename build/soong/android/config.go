package android

// Global config used by Cyber soong additions
var cyberConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.cyberaosp.keydisabler",
	},
}
