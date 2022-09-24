<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <ProfilePage msg="Welcome to my profile page."/>
</template>

<script>
import ProfilePage from './components/ProfilePage.vue'

export default {
  name: 'App',
  components: {
    ProfilePage
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
