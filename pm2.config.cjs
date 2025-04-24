module.exports = {
  apps: [
    {
      name: "distro",
      exec_mode: "cluster",
      instances: "max",
      script: "./build/index.js",
      env: {
        PORT: 3000
      }
    },
  ],
};