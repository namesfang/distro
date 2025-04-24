import * as Components from "$components/icons"

declare global {
  declare namespace icons {
    type Name = keyof typeof Components
    interface Props {
      fill?: boolean
      mini?: boolean
      small?: boolean
      medium?: boolean
      large?: boolean
      size?: 'min' | 'small' | 'medium' | 'large' | number | null
    }
  }
}