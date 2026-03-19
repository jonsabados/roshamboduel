<script setup lang="ts">
import { ref, onMounted } from 'vue'
import rockImg from '@/assets/ROCK.png'
import paperImg from '@/assets/PAPER.png'
import scissorsImg from '@/assets/SCISSORS.png'

type Status = 'checking' | 'ok' | 'error' | 'offline'
const apiStatus = ref<Status>('checking')

onMounted(async () => {
  try {
    const apiUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080'
    const response = await fetch(`${apiUrl}/health`)
    if (response.ok) {
      const data = await response.json()
      apiStatus.value = data.status
    } else {
      apiStatus.value = 'error'
    }
  } catch {
    apiStatus.value = 'offline'
  }
})
</script>

<template>
  <div class="container">
    <h1>Roshambo Duel</h1>

    <div class="choices">
      <img :src="rockImg" alt="Rock" class="choice" />
      <img :src="paperImg" alt="Paper" class="choice" />
      <img :src="scissorsImg" alt="Scissors" class="choice" />
    </div>

    <p class="status">
      API Status: <span :class="apiStatus">{{ apiStatus === 'checking' ? 'checking...' : apiStatus }}</span>
    </p>
  </div>
</template>

<style scoped>
/* Mobile-first base styles */
.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 1rem;
  text-align: center;
  font-family: system-ui, -apple-system, sans-serif;
}

h1 {
  font-size: 2rem;
  margin-bottom: 1.5rem;
  background: linear-gradient(135deg, #ff6b6b, #feca57, #48dbfb);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.choices {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 0.75rem;
  margin-bottom: 1.5rem;
}

.choice {
  width: 100px;
  height: 100px;
  object-fit: contain;
  cursor: pointer;
  transition: transform 0.2s;
}

.choice:active {
  transform: scale(0.95);
}

.status {
  font-size: 1rem;
  color: #666;
}

.status span {
  font-weight: bold;
}

.status span.ok {
  color: #27ae60;
}

.status span.error,
.status span.offline {
  color: #e74c3c;
}

.status span.checking {
  color: #f39c12;
}

/* Tablet and up */
@media (min-width: 640px) {
  .container {
    padding: 2rem;
  }

  h1 {
    font-size: 2.5rem;
    margin-bottom: 2rem;
  }

  .choices {
    gap: 1rem;
    margin-bottom: 2rem;
  }

  .choice {
    width: 150px;
    height: 150px;
  }

  .status {
    font-size: 1.1rem;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  h1 {
    font-size: 3rem;
  }

  .choice {
    width: 200px;
    height: 200px;
  }

  .choice:hover {
    transform: scale(1.1);
  }

  .status {
    font-size: 1.2rem;
  }
}
</style>