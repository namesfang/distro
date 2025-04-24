export const computedWidth = ({ mini, small, medium, large, size }: Omit<icons.Props, 'fill'>): string | null => {
  const pieces = [mini, small, medium, large]
  const values = ['12px', '20px', '28px', '36px'];
  const sizes = ['mini', 'small', 'medium', 'large'];

  if (null === size) {
    return null
  }

  if (typeof size === 'number') {
    return `${size}px`
  }

  for(const i in pieces) {
    if (pieces[i] === true) {
      return values[i]
    }
  }

  for(const n in sizes) {
    if (sizes[n] === size) {
      return values[n]
    }
  }

  return values[2]
}