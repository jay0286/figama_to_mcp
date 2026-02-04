import { useState, useEffect } from 'react';
import { api } from '../services/api';

export function useHomeData() {
  const [user, setUser] = useState(null);
  const [bookedClasses, setBookedClasses] = useState([]);
  const [popularClasses, setPopularClasses] = useState([]);
  const [healthStats, setHealthStats] = useState(null);
  const [recipes, setRecipes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function fetchData() {
      try {
        setLoading(true);
        const [userData, booked, popular, stats, recipeData] = await Promise.all([
          api.getUserProfile(),
          api.getBookedClasses(),
          api.getPopularClasses(),
          api.getHealthStats(),
          api.getRecentRecipes(),
        ]);

        setUser(userData);
        setBookedClasses(booked);
        setPopularClasses(popular);
        setHealthStats(stats);
        setRecipes(recipeData);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    fetchData();
  }, []);

  return {
    user,
    bookedClasses,
    popularClasses,
    healthStats,
    recipes,
    loading,
    error,
  };
}
